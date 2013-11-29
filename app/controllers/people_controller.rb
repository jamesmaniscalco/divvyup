class PeopleController < ApplicationController


  def index
    @people = Person.all
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.create(person_params)

    if @person.save
      redirect_to action: 'index'
    else
      render 'new'
    end
  end
  
  def show
    @person = Person.find(params[:id])
    @item_types = ItemType.all
  end



  def person_params
    params.require(:person).permit(:name)
  end
end
