class DevicelogsController < ApplicationController
    def index
        @devices = Device.all
    end
end
