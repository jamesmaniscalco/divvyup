class ItemsController < ApplicationController

  before_filter :find_item, :only => [ :show, :finish ]
  before_filter :owned_by_current_group, :only => [ :show, :finish ]

  def index
    @items = current_group.items
  end

  def new
    @item = Item.new
    @people = Person.all
    @item_types = ItemType.all
  end

  def create
    @item = Item.create(item_params)
    @item.group = current_group
    @people = Person.all
    @item_types = ItemType.all

    if @item.save
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def show
  end

  def finish
    @item.finished = true
    @item.finished_at = DateTime.now

    unless @item.save
      flash[:alert] = "item could not be finished"
    end

    redirect_to action: 'index'
  end

  def find_item
    @item = Item.find(params[:item_id] || params[:id])  # the second part shouldn't be evaluated if the first returns true :)
  end

  def owned_by_current_group
    unless @item.group == current_group
      flash[:alert] = "whoops!  you don't have permission to do that."
      redirect_to action: 'index'
    end
  end

  def item_params
    params.require(:item).permit(:person_id, :item_type_id, :id, :comment)
  end
end
