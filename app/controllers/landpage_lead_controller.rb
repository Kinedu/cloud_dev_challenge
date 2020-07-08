
class LandpageLeadController

    def self.list
        items = LandpageLeads.scan()
        items
          .map { |r| { :first_name => r.first_name, :last_name => r.last_name,:email => r.email, :phone => r.phone, :company_name => r.company_name, :company_industry => r.company_industry } }
          .sort { |a, b| a[:created_at] <=> b[:created_at] }
          .to_json
    end

    def self.create(params)
        item = LandpageLeads.new(id: SecureRandom.uuid, created_at: Time.now, updated_at: Time.now )
        item.first_name = params[:first_name]
        item.last_name = params[:last_name]
        item.phone = params[:phone]
        item.email = params[:email]
        item.company_name = params[:company]
        item.company_industry = params[:industry]
        item.save!
        item
    end

end
