class UsesController < LoggedInController


  def index
    @uses = current_group.uses
  end

  def new
    @use = Use.new(new_use_params)
    new_or_create_init
  end

  def create
    # @use = Use.create(use_params)
    @use = Use.new(use_params)
    @use.group = current_group

    if @use.save
      redirect_to items_url
    else
      new_or_create_init
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
    @people = current_group.people
    @items = current_group.items.available
    if defined?(@use.item) && @use.item != nil
      @units = unit_choices(@use.item.item_type.measure_by)
    else
      @units = unit_choices('all')
    end
  end
end
