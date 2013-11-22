class StoragesController < ApplicationController

  # PT:: make sure that the user is authenticated.
  before_filter :authenticate_user! #, :except => :create

  # GET /storages
  # GET /storages.json
  def index
    @storages = current_user.storages.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @storages }
    end
  end

  # GET /storages/1
  # GET /storages/1.json
  def show
    @storage = current_user.storages.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @storage }
    end
  end

  # GET /storages/new
  # GET /storages/new.json
  def new
    @storage = current_user.storages.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @storage }
    end
  end

  # GET /storages/1/edit
  def edit
    @storage = current_user.storages.find(params[:id])
  end

  # POST /storages
  # POST /storages.json
  #
  def create
    # user = User.first
    # storage_data = Hash.new
    # storage_data[:file] = params[:file]
    # storage_data[:device_id] = params[:device_id]
    # storage_data[:compressed] = params[:compressed] == 'true'
    # storage_data[:file_type] = params[:file_type]
    # puts "  =====> #{storage_data}"
    # @storage = user.storages.new(storage_data)
    @storage = current_user.storages.new(params[:storage])

    respond_to do |format|
      if @storage.save
        format.html { redirect_to @storage, notice: 'Storage was successfully created.' }
        format.json { render json: @storage, status: :created, location: @storage }
      else
        format.html { render action: "new" }
        format.json { render json: @storage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /storages/1
  # PUT /storages/1.json
  def update
    @storage = current_user.storages.find(params[:id])

    respond_to do |format|
      if @storage.update_attributes(params[:storage])
        format.html { redirect_to @storage, notice: 'Storage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @storage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /storages/1
  # DELETE /storages/1.json
  def destroy
    @storage = current_user.storages.find(params[:id])
    @storage.destroy

    respond_to do |format|
      format.html { redirect_to storages_url }
      format.json { head :no_content }
    end
  end

  # GET /storages/show_upload
  # GET /storages/show_upload.json
  #
  def show_upload
    @storage = current_user.storages.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @storage }
    end
  end

  # Get /storage/:id/process
  def parse
    @storage = current_user.storages.find(params[:id])
    @storage.parse

  end

  # POST /upload
  # POST /upload.json
  #
  def upload
    user = User.first
    storage_data = Hash.new
    storage_data[:file] = params[:file]
    storage_data[:device_id] = params[:device_id]
    storage_data[:compressed] = params[:compressed] == 'true'
    storage_data[:file_type] = params[:file_type]
    puts "  =====> #{storage_data}"
    @storage = user.storages.new(storage_data)

    respond_to do |format|
      if @storage.save
        format.html { redirect_to @storage, notice: 'Storage was successfully created.' }
        format.json { render json: @storage, status: :created, location: @storage }
      else
        format.html { render action: "new" }
        format.json { render json: @storage.errors, status: :unprocessable_entity }
      end
    end
  end


end
