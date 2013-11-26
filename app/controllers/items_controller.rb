class ItemsController < ApplicationController


  def index
    @items = Item.order(finished: :asc, created_at: :desc)
  end

  def new
    @item = Item.new
    @people = Person.all
    @item_types = ItemType.all
  end

  def create
    @item = Item.create(item_params)
    @people = Person.all
    @item_types = ItemType.all

    if @item.save
      redirect_to action: 'index'
    else
      puts @item.errors
      render 'new'
    end
    
  end

  def finish
    @item = Item.find(params[:item_id])
    @item.finished = true
    @item.finished_at = DateTime.now

    unless @item.save
      flash[:error] = "item could not be finished"
    end

    redirect_to action: 'index'
  end


  def item_params
    params.require(:item).permit(:person_id, :item_type_id, :id, :comment)
  end
end
