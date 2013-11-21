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
      redirect_to @index
    else
      render 'new'
    end
    
  end



  def person_params
    params.require(:person).permit(:name)
  end
end
