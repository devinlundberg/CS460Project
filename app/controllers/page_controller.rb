class PageController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:usercontracts,:managecontracts]
  protect_from_forgery :secret => "Yea This is a pretty lame secret but whatevs....32196756"
  
  def index
    #completed
    @contracts=Contract.where("open"=>false)
  end

  def about
  end

  def hire
    if request.post?
      requester=params[:requester]
      client=params[:client]
      price=params[:price]
      instructions=params[:special]
      @contract=Contract.create
      @contract.client=client
      @contract.price=price
      @contract.instructions=instructions
      @contract.requestedBy=requester
      @contract.humanizer_answer=params[:humanizer_answer]
      @contract.humanizer_question_id=params[:humanizer_question_id]
      if @contract.save
        redirect_to hire_path, :notice => 'Thank you for your patronage!'
      else
        redirect_to hire_path, :notice=>  @contract.errors.to_a
      end
    end
    @contract=Contract.create
  end

  def managecontracts
    if not current_user.admin
      redirect_to(root_path)
    end
    if request.post?
      accepted=params[:accept]
      denied=params[:deny]
      deleted=params[:delete]
      unlisted=params[:unlist]
      if accepted
      accepted.each do |id|
        contract=Contract.find(id)
        if contract
          contract.pending=false
          contract.save
        end
      end
      end
      if denied
      denied.each do |id|
        contract=Contract.find(id)
        if contract
          contract.pending=false
          contract.user=nil
          contract.save
        end
      end
      end
      if deleted
      deleted.each do |id|
        contract=Contract.find(id)
        if contract
          contract.destroy
        end
      end
      end
      if unlisted
      unlisted.each do |id|
        contract=Contract.find(id)
        if contract
          contract.instructions="Unlisted"
          contract.user=nil
          contract.pending=false
          contract.save
        end
      end
      end
      
    end
    #open
    @current=Contract.where("pending"=>false,"open"=>true)
    #pending
    @pending=Contract.where("pending"=>true)
    #available
    @available=Contract.where({:user_id=>nil,:pending=>false,:open=>true}).where("instructions<> ?",'Unlisted')
  end

  def usercontracts
    if request.post?
      completed=params[:completed]
      canceled=params[:cancel]
      applied=params[:apply]
      if completed
      completed.each do |id|
        contract=current_user.contracts.find(id)
        if contract
          contract.open=false
          contract.save
        end
      end
      end
      if canceled
      canceled.each do |id|
        contract=current_user.contracts.find(id)
        if contract
          contract.pending=false
          contract.user=nil
          contract.save
        end
      end
      end
      if applied
      applied.each do |id|
        contract=Contract.find(id)
        if contract
          contract.pending=true
          contract.user=current_user
          contract.save
        end
      end
      end
      
    end
    #pending
    @pending=current_user.contracts.where("pending"=>true)
    #available
    @current=current_user.contracts.where("pending"=>false,"open"=>true)
    #current
    @available=Contract.where({:user_id=>nil,:pending=>false,:open=>true}).where("instructions<> ?",'Unlisted')
  end
  

end
