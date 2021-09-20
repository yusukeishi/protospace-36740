class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]

  before_action :authenticate_user!, except: [:index, :show]

  before_action :prototype_edit, only: [:edit, :update, :destroy]


  def index
    @prototype = Prototype.includes(:user)
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

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end


  def prototype_edit
    redirect_to root_path unless current_user == @prototype.user
    
  end
end