class ItemsController < ApplicationController


  def index
    @items = Item.all
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
      render 'new'
    end
    
  end



  def item_params
    params.require(:item).permit(:person_id, :item_type_id)
  end
end
