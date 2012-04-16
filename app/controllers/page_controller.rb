class PageController < ApplicationController
  def index
    #completed
    @contracts=Contract.where("open = false")
  end

  def about
  end

  def hire
  end

  def managecontracts
  end

  def usercontracts
    #pending
    #available
    #current
  end
  

end
