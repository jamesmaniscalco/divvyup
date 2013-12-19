class PeopleController < ApplicationController

  before_filter :find_person, :only => [ :show ]
  before_filter :owned_by_current_group, :only => [ :show ]

  def index
    if group_signed_in?
      @people = current_group.people
    else
      @people = Person.none
    end
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.create(person_params)
    @person.group = current_group

    if @person.save
      redirect_to action: 'index'
    else
      render 'new'
    end
  end
  
  def show
    @person = Person.find(params[:id])
    @item_types = current_group.item_types
  end

  def find_person
    @person = Person.find(params[:id])
  end

  def owned_by_current_group
    unless @person.group == current_group
      permissions_error_flash
    end
  end

  def person_params
    params.require(:person).permit(:name)
  end
end
