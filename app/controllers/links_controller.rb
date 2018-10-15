class LinksController < ApplicationController
  include ApplicationHelper

  def index
  	links
  end

  def create
  	@link = Link.new(link_params)
  	assign_link_short
   
   	if @link.destination == "" 
    	@error = "Link can't be empty" 
    else
    	@success = "New link added successfully" if @link.save
   	end

	links
    render "index"
  end

  def destroy
  	@link = Link.find(params[:id])

  	if @link.destroy
  		@success = "Link deleted successfully"
  	else
  		@error = "Sth went wrong"
  	end

  	links
  	render "index"
  end

  def redirect
  	@short_link = params[:short]

  	if @short_link.length == 8
  		link = Link.find_by(short: @short_link)

  		if link.nil?
  			render "not_found"
  		else
  			redirect_to "#{link_protocol(link.destination)}#{link_body(link.destination)}"
  		end
  	else
  		render "wrong_string"
  	end
  end

  private

  def links
  	@server_url = request.base_url
  	@links ||= Link.all
  end

  def link_params
  	params.require(:link).permit(:destination)
  end

  def assign_link_short
  	while !@link.short do
      short_link = render_link_short

      @link.short = short_link unless Link.where(short: short_link).exists?
  	end
  end

  def render_link_short
  	short_string = ''
  	charArray = [*('a'..'z'),*('A'..'Z'),*('0'..'9')]

  	8.times { short_string << charArray.sample }

  	short_string
  end
end