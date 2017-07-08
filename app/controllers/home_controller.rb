class HomeController < ApplicationController
  skip_before_action :authenticate_tenant!, :only => [ :index ]

    def welcome
    end


  def index
    if user_signed_in?

        # was there a previous error msg carry over? make sure it shows in flasher
      flash[:notice] = flash[:error] unless flash[:error].blank?
      redirect_to(  welcome_path()  )

    else

      if flash[:notice].blank?
        flash[:notice] = "sign in if your organization has an account"
      end

    end   # if logged in .. else first time

  end
end
