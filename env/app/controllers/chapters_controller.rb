class ChaptersController < ApplicationController
  # GET /chapters
  # GET /chapters.xml
  def index
    @chapters = Chapter.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @chapters }
    end
  end

  # GET /chapters/1
  # GET /chapters/1.xml
  def show
    @chapters = Chapter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chapters }
    end
  end

  # GET /chapters/new
  # GET /chapters/new.xml
  def new
    @chapters = Chapter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @chapters }
    end
  end

  # GET /chapters/1/edit
  def edit
    @chapters = Chapter.find(params[:id])
  end

  # POST /chapters
  # POST /chapters.xml
  def create
    @chapters = Chapter.new(params[:chapters])

    respond_to do |format|
      if @chapters.save
        flash[:notice] = 'Chapter was successfully created.'
        format.html { redirect_to(@chapters) }
        format.xml  { render :xml => @chapters, :status => :created, :location => @chapters }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @chapters.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /chapters/1
  # PUT /chapters/1.xml
  def update
    @chapters = Chapter.find(params[:id])

    respond_to do |format|
      if @chapters.update_attributes(params[:chapters])
        flash[:notice] = 'Chapter was successfully updated.'
        format.html { redirect_to(@chapters) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chapters.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.xml
  def destroy
    @chapters = Chapter.find(params[:id])
    @chapters.destroy

    respond_to do |format|
      format.html { redirect_to(chapters_url) }
      format.xml  { head :ok }
    end
  end
end
