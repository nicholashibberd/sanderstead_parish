module SlideshowHelper
	def slideshow(region, &proc)
		slideshow = Slideshow.new(region)
		capture(slideshow, &proc)
	end

	def render_slideshow(region)
		render "widgets/#{controller.action_name}/slideshow_widget", region: region
	end

	class Slideshow
		attr_accessor :region
		
		def initialize(region)
			@region = region
		end

		def slides
			@slides ||= @region.widgets
		end

		def first_slide
			slides.first
		end

		def remaining_slides
			slides.asc(:position)[1..-1]
		end
	end
end