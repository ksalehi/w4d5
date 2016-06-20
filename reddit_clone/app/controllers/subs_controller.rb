class SubsController < ApplicationController
  before_action :ensure_logged_in!, except: [:index, :show]
  before_action only: [:edit, :update, :destroy] do
    ensure_moderator(get_mod_id)
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      flash_add("Sub successfully created!")
      redirect_to sub_url(@sub)
    else
      flash_now(@sub.errors.full_messages)
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(sub_params)
      flash_add("Sub edited successfully")
      redirect_to sub_url(@sub)
    else
      flash_now(@sub.errors.full_messages)
      render :edit
    end
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def destroy
    @sub = Sub.find(params[:id])

    if @sub.destroy
      flash_add("Sub successfully deleted.")
      redirect_to subs_url
    else
      flash_now("Problem deleting sub.")
      render :show
    end
  end

  def get_mod_id
    mod_id = Sub.find(params[:id]).moderator_id
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end
end
