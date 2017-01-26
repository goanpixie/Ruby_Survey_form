class SurveysController < ApplicationController
  def index
  	if !session[:views]
  		session[:views]=0
  	end
  end

  def process_form
       session[:views]=session[:views]+1
       session[:result] =params[:survey]
       flash[:success]= "Thank yu for submitting the form. You have now submitted the form #{session[:views]} time(s)"
  	   redirect_to "/surveys/result"
  end

  def result
  	@success_message = flash[:success]
  	@result = session[:result]
  end
end
