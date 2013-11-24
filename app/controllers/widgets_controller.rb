class WidgetsController < ApplicationController

  # PT:: make sure that the user is authenticated.
  before_filter :authenticate_user!

  # GET /widgets
  # GET /widgets.json
  def index
    page = params[:page] || 1
    @widgets = current_user.widgets.page(page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @widgets }
    end
  end

  # GET /widgets/1
  # GET /widgets/1.json
  def show
    page = params[:page] || 1
    @widget = current_user.widgets.find(params[:id])
    @analytics = @widget.get_analytics(page)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @widget }
    end
  end

  # GET /widgets/new
  # GET /widgets/new.json
  def new
    @widget =  current_user.widgets.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @widget }
    end
  end

  # GET /widgets/1/edit
  def edit
    @widget =  current_user.widgets.find(params[:id])
  end

  # POST /widgets
  # POST /widgets.json
  def create
    @widget =  current_user.widgets.new(params[:widget])

    respond_to do |format|
      if @widget.save
        format.html { redirect_to @widget, notice: 'Widget was successfully created.' }
        format.json { render json: @widget, status: :created, location: @widget }
      else
        format.html { render action: "new" }
        format.json { render json: @widget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /widgets/1
  # PUT /widgets/1.json
  def update
    @widget =  current_user.widgets.find(params[:id])

    respond_to do |format|
      if @widget.update_attributes(params[:widget])
        format.html { redirect_to @widget, notice: 'Widget was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @widget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /widgets/1
  # DELETE /widgets/1.json
  def destroy
    @widget =  current_user.widgets.find(params[:id])
    @widget.destroy

    respond_to do |format|
      format.html { redirect_to widgets_url }
      format.json { head :no_content }
    end
  end

  def run
    Widget.load_widgets
    Widget.run_widgets
  end
end
