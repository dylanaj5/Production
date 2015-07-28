class MessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :user_signed_in?, only: [:edit, :destroy, :update] 
    helper_method :verify_recaptcha

    def index
        @messages=Message.all
    end
    def new
        @messages=Message.new
    end
    def show
        @message=Message.find(params[:id])
    end
    def destroy
        @messages=Message.find(params[:id])
        @messages.destroy
        redirect_to '/'
    end
    def auth
        @oauth = Koala::Facebook::OAuth.new(app_id, app_secret, callback_url)
    end
    def change
        add_column :messages, :ip, :string
    end
    def respond
        @counts = Message.all.count
        respond_to do |format|
            format.json {render json: @counts}
        end
    end
    def update
    @message = Message.find(params[:id])
      if @message.update(recipe_params)
        redirect_to @message
      else
        render 'edit'
      end
    end
    def create
        @messages = Message.new(message_params) 
        @messages.ip = request.remote_ip
        @messages.posted_by = current_user.email
        @messages.post_time = Time.now.utc.to_date
  	        if verify_recaptcha(:model => @Message, :message => "Oh! It's an error with reCAPTCHA!")
  	            @messages.save
    	        redirect_to '/' 
  	        else
  	            render 'new'
  	        end
    end
    private
    def message_params
        params.require(:message).permit(:content, :subject, :id, :ip, :post_time)
    end
    
end