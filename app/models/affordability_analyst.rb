class AffordabilityAnalyst


  def find_closest_rent_neighborhoods(user_max_rent)
    max_avg_rent = user_max_rent * 1.2
    neighborhoods = Neighborhood.where('rent <= ?', max_avg_rent).order(rent: :desc).limit(3)
    if neighborhoods.empty?
      Neighborhood.order(:rent).limit(3)
    else
      neighborhoods
    end
  end


end
