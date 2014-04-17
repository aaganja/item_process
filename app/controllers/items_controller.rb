class ItemsController < ApplicationController
  # GET /items
  # GET /items.json
  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    if Valuetoprocess.last == nil
      doccode = 1
    else
      doccode = Valuetoprocess.last.id + 1
    end
    amount = 10
    vtp= Valuetoprocess.new
    vtpv = {DocDate: "2014-04-17",CustomerCode: "CUST1",DocCode: (doccode),Commit: "1",DocType: "SalesInvoice",Addresses: [{AddressCode: "1",Line1: "100 Ravine Lane NE",City: "Bainbridge Island",Region: "WA",  PostalCode: "98110"}], Lines: [{LineNo: "1",DestinationCode: "1",OriginCode: "1",Qty: 1, Amount: amount }] }
    vtp.value = vtpv.to_json
    vtp.save
    ProcessWorker.perform_async(vtp.id)
    redirect_to items_path
    # @item = Item.new(params[:item])

    # respond_to do |format|
    #   if @item.save
    #     format.html { redirect_to @item, notice: 'Item was successfully created.' }
    #     format.json { render json: @item, status: :created, location: @item }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @item.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end
end
