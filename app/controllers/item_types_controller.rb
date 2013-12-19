  class ItemTypesController < LoggedInController

  before_filter :find_item_type, :only => [ :show ]
  before_filter :owned_by_current_group, :only => [ :show ]

  def index
    if group_signed_in?
      @item_types = current_group.item_types
    else
      @item_types = ItemType.none
    end
  end

  def new
    @item_type = ItemType.new
  end

  def create
    @item_type = ItemType.create(item_type_params)
    @item_type.group = current_group

    if @item_type.save
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def show
    @item_type = ItemType.find(params[:id])
    @people = current_group.people
  end

  def find_item_type
    @item_type = ItemType.find(params[:id])
  end

  def owned_by_current_group
    unless @item_type.group == current_group
      permissions_error_flash
    end
  end

  def item_type_params
    params.require(:item_type).permit(:name, :measure_by)
  end
end
