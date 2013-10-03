class DataRecordsController < ApplicationController
  # GET /data_records
  # GET /data_records.json
  def index
    @data_records = DataRecord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @data_records }
    end
  end

  # GET /data_records/1
  # GET /data_records/1.json
  def show
    @data_record = DataRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @data_record }
    end
  end

  # GET /data_records/new
  # GET /data_records/new.json
  def new
    @data_record = DataRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @data_record }
    end
  end

  # GET /data_records/1/edit
  def edit
    @data_record = DataRecord.find(params[:id])
  end

  # POST /data_records
  # POST /data_records.json
  def create
    @data_record = DataRecord.new(params[:data_record])

    respond_to do |format|
      if @data_record.save
        format.html { redirect_to @data_record, notice: 'Data record was successfully created.' }
        format.json { render json: @data_record, status: :created, location: @data_record }
      else
        format.html { render action: "new" }
        format.json { render json: @data_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /data_records/1
  # PUT /data_records/1.json
  def update
    @data_record = DataRecord.find(params[:id])

    respond_to do |format|
      if @data_record.update_attributes(params[:data_record])
        format.html { redirect_to @data_record, notice: 'Data record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @data_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data_records/1
  # DELETE /data_records/1.json
  def destroy
    @data_record = DataRecord.find(params[:id])
    @data_record.destroy

    respond_to do |format|
      format.html { redirect_to data_records_url }
      format.json { head :no_content }
    end
  end
end
