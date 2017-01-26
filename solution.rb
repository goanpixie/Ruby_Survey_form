class SurveysController < ApplicationController
  def index
  	if !session[:views]
  		session[:views]=0
  	end
  end

  def process_form
       session[:views]=session[:views]+1
       session[:result] =params[:survey]
       flash[:success]= "Thank you for submitting the form. You have now submitted the form #{session[:views]} time(s)"
  	   redirect_to "/surveys/result"
  end

  def result
  	@success_message = flash[:success]
  	@result = session[:result]
  end
end

-------
index.html

<div>
  <form action="/surveys" method="post">
      <input name="authenticity_token" value="<%= form_authenticity_token %>" type="hidden">

      <div>
      <label>Your Name:</label>
      <input type="text" name="survey[name]">
      </div>

      <div>
      <label>Select Dojo:</label>
      <select name="survey[location]">
      <option value="Mountainview, CA"> Mountainview, CA</option>
      <option value="Seattle, WA"> Seattle, WA</option>
      <option value="Greensboro, DC"> Greensboro, DC</option>
      <option value="Berkeley, CA"> Berkeley, CA</option>
      </select>
      </div>

      <div>
      <label>Favorite Langauge:</label>
      <select name="survey[langauge]">
      <option value="Javascript"> Javascript</option>
      <option value="Python"> Python</option>
      <option value="Ruby"> Ruby</option>
      <option value="React"> React</option>
      </select>
      </div>

      <div>
      <label>Comment:</label>
      <textarea name="survey[comment]" cols="30" rows="10"></textarea>
      </div>


      <div>
      <input type="submit" value="Submit">
      </div>

  </form>

</div>
------------

result.html

<div>
  <%if flash[:success]%>
  <p><%=flash[:success]%></p>
  <% end %>

  <table>
    <tr>
      <td>Submitted information</td>
    </tr>
    <tr>
      <td>Name</td>
      <td><%= @result["name"]%></td>
    </tr>

    <tr>
      <td>Location</td>
      <td><%= @result["location"]%></td>
    </tr>

    <tr>
      <td>Favorite Langauge</td>
      <td><%= @result["langauge"]%></td>
    </tr>

    <tr>
      <td>Comment</td>
      <td><%= @result["comment"]%></td>
    </tr>

    <tr>
      <td><%= button_to "Go Back", {:controller =>"surveys", :action => "index" }, :method=> :get %></td>
    </tr>
-------------

Rails.application.routes.draw do
  get 'surveys/index'

  get 'surveys/result'

  root 'surveys#index'

  post 'surveys' => "surveys#process_form"

