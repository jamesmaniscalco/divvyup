class UsesController < ApplicationController


  def index
    @uses = current_group.uses
  end

  def new
    @use = Use.new(new_use_params)
    new_or_create_init
  end

  def create
    @use = Use.create(use_params)
    @use.group = current_group
    new_or_create_init

    if @use.save
      redirect_to items_url
    else
      render 'new'
    end
    
  end



  def use_params
    params.require(:use).permit(:person_id, :item_id, :unit, :amount)
  end

  def new_use_params
    params.fetch(:use, {}).permit(:item_id)
  end

  def new_or_create_init
    @people = Person.all
    @items = Item.available
    if defined?(@use.item) && @use.item != nil
      @units = unit_choices(@use.item.item_type.measure_by)
    else
      @units = unit_choices('all')
    end
  end
end
