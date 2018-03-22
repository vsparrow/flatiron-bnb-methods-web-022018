class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods


  def city_openings(startDate,endDate)
    available = []
    self.listings.map do |listing|
      listing.reservations.each do |reservation|
        # STDERR.puts "******#{reservation.checkin.class}" Date
        # STDERR.puts "******#{startDate.class}" #String
        # STDERR.puts "******#{DateTime.strptime(startDate)}" #String
        # STDERR.puts "******#{DateTime.iso8601(startDate)}" #2014-05-01T00:00:00+00:00
        # STDERR.puts "******#{DateTime.iso8601(endDate)}" #2014-05-05T00:00:00+00:00
        # STDERR.puts "******#{reservation.checkin}" #2014-05-10
        # if reservation.checkin >= DateTime.iso8601(startDate)
        #   if reservation.checkout <= DateTime.iso8601(endDate)
        #     # "not available"
        #     available << listing
        #
        #   else
        #       # available << listing
        #       "not available"
        #
        #   end #inner if
        # end #if

        # if (reservation.checkin..reservation.checkout).overlaps?(DateTime.iso8601(startDate)..DateTime.iso8601(endDate))
        #   available << listing
        # end
        # if !(reservation.checkin..reservation.checkout).overlaps?(DateTime.iso8601(startDate)..DateTime.iso8601(endDate))
        #   available << listing
        # end
        # STDERR.puts "************#{self.name}" # NYC
        if (DateTime.iso8601(startDate)...DateTime.iso8601(endDate)).overlaps?(reservation.checkin...reservation.checkout)
          available << listing
        end
      end #listings.reservations
    end#self.listings
    available
    # available.uniq
  end #city_openings


  def self.highest_ratio_res_to_listings
    maxCitycount=nil
    maxCityName=nil
    City.all.each do |city|
      citycount=0
      city.listings.each do |listing|
        citycount += listings.reservations.count
      end#city.listings
      if citycount > maxCitycount
        maxCitycount = citycount
        maxCityName = city.name
      end #if
    end#each
    maxCityName
  end#methods
end
