class ItemsController < ApplicationController
  include SessionsHelper
 before_action :correct_user, only: [:edit,:update]
  def new
    @item = Item.new
  end

  def create
   @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = '投稿されました'
      redirect_to :users_show
        if params[:item][:image]
          File.binwrite("public/img/#{@item.id}.jpeg",params[:item][:image].reade)
          @item.update(img_name: '#{@item.id}.jpeg')
        else
          @item.update(img_name: "default.jpeg")
        end
    else
      flash[:danger] = '投稿できませんでした'
      render 'items/new'
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
     @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
     
    if @item.update(item_params)
      flash[:success] ='編集が完了しました'
      redirect_to @item
    else
      flash[:danger] = '不正です。'
      render :edit
    end
  end

  def destroy
  end
  
  private
  
  def item_params
    params.require(:item).permit(:title, :url, :content)
  end
  

end
