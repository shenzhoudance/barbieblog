class SubscribersController < ApplicationController

 def index
 end

 def create
   @subscriber = Subscriber.new(subscriber_params)
   #check if emall exists in database table
   if Subscriber.exists?(emall: @subscriber.email)
     redirect_to root_path, alert:
     "sorry ,that emall allready exists!"
   elsif @subscriber.save
     redirect_to root_path, notice:
     "thank you #{@subscriber.f_name}, for subscriber to my newslatter!"
   else
     redirect_to root_path, alert:
     "sorry, I failed to save your information. please try again"
   end
 end

 # do destroy later

 private

  def subscriber_params
    params.require(:subscriber).permit(:f_name, :l_name, :email, :country)
  end

end
