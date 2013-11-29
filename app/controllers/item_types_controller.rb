class ItemTypesController < ApplicationController


  def index
    @item_types = ItemType.all
  end

  def new
    @item_type = ItemType.new
  end

  def create
    @item_type = ItemType.create(item_type_params)

    if @item_type.save
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def show
    @item_type = ItemType.find(params[:id])
    @people = Person.all
  end


  def item_type_params
    params.require(:item_type).permit(:name, :measure_by)
  end
end
