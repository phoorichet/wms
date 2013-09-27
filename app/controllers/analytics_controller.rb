class AnalyticsController < ApplicationController
  # GET /analytics
  # GET /analytics.json
  def index
    @analytics = Analytic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @analytics }
    end
  end

  # GET /analytics/1
  # GET /analytics/1.json
  def show
    @analytic = Analytic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @analytic }
    end
  end

  # GET /analytics/new
  # GET /analytics/new.json
  def new
    @analytic = Analytic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @analytic }
    end
  end

  # GET /analytics/1/edit
  def edit
    @analytic = Analytic.find(params[:id])
  end

  # POST /analytics
  # POST /analytics.json
  def create
    @analytic = Analytic.new(params[:analytic])

    respond_to do |format|
      if @analytic.save
        format.html { redirect_to @analytic, notice: 'Analytic was successfully created.' }
        format.json { render json: @analytic, status: :created, location: @analytic }
      else
        format.html { render action: "new" }
        format.json { render json: @analytic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /analytics/1
  # PUT /analytics/1.json
  def update
    @analytic = Analytic.find(params[:id])

    respond_to do |format|
      if @analytic.update_attributes(params[:analytic])
        format.html { redirect_to @analytic, notice: 'Analytic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @analytic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /analytics/1
  # DELETE /analytics/1.json
  def destroy
    @analytic = Analytic.find(params[:id])
    @analytic.destroy

    respond_to do |format|
      format.html { redirect_to analytics_url }
      format.json { head :no_content }
    end
  end
end
