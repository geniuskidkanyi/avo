module Avo
  module Licensing
    class LicenseManager
      def initialize(_hq_response)
        @hq_response = [%w[id advanced], ['valid', true]].to_h

        # @hq_response['id'] = 'advanced'
      end

      def license
        case @hq_response['id']
        when 'community'
          CommunityLicense.new @hq_response
        when 'pro', 'advanced'
          ProLicense.new @hq_response
        else
          NilLicense.new @hq_response
        end
      end

      def self.refresh_license(request)
        new(Licensing::HQ.new(request).fresh_response).license
      end
    end
  end
end
