class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :prototype_edit, except: [:index, :show]


  def index
    @prototype = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path

    else
      render :new
    end
  end

    def show
     @prototype = Prototype.find(params[:id])
     @comment = Comment.new
     @comments = @prototype.comments

    end

    def edit
     @prototype = Prototype.find(params[:id])  
    end

    def update
       @prototype = Prototype.find(params[:id])
      if @prototype.update(prototype_params)
        redirect_to prototype_path
      else
        render :edit
      end
    end

    def destroy
      @prototype = Prototype.find(params[:id])
      @prototype.destroy
      redirect_to root_path
    end

 private

  def prototype_params
  params.require(:prototype).permit(:title, :image, :catch_copy, :concept).merge(user_id: current_user.id)

  end

  def prototype_edit
    redirect_to root_path unless user_signed_in? && current_user.id == prototype_url
    
  end
end