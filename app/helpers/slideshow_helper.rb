module SlideshowHelper
	def slideshow(region, &proc)
		slideshow = Slideshow.new(region)
		capture(slideshow, &proc)
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