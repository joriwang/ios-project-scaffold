require 'mail'
module Fastlane
  module Actions

    class SendemailAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        smtp_config = { :address   => "smtp.exmail.qq.com",
                :port      => 587,
                :user_name => "wanghui@qing-jin.com",
                :password  => "Jori569021230", 
                :enable_ssl => true
              }

        Mail.defaults do
            delivery_method :smtp, smtp_config
        end
        mail = Mail.new do
          from    'wanghui@qing-jin.com'
          to      params[:email_list]
          subject params[:title]
        
          html_part do
            content_type 'text/html; charset=UTF-8'
            body "<h1>#{params[:title]}</h1><a href=#{params[:url]} style=\"color:blue;font-size:40px;\">点击下载</a>"
          end
        end

        puts mail.to_s
        mail.deliver!
        # sh "shellcommand ./path"

        # Actions.lane_context[SharedValues::SENDEMAIL_CUSTOM_VALUE] = "my_val"
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "发送 AdHoc 版给指定接收者"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "使用时必须指定邮件接收者和 AdHoc 版本下载网址"
      end

      def self.available_options
        # Define all options your action supports.

        # Below a few examples
        [
         FastlaneCore::ConfigItem.new(key: :email_list,
                                      env_name: "CY_SENDEMAIL_RECEIVER_LIST", # The name of the environment variable
                                      description: "接收邮件者列表", # a short description of this parameter
                                      is_string: true,
                                      verify_block: proc do |value|
                                         UI.user_error!("未指定邮件接收人") unless (value and not value.empty?)
                                      end),
         FastlaneCore::ConfigItem.new(key: :title,
                                      env_name: "CY_SENDEMAIL_TITLE", # The name of the environment variable
                                      description: "邮件标题", # a short description of this parameter
                                      is_string: true,
                                      verify_block: proc do |value|
                                         UI.user_error!("未指定邮件标题") unless (value and not value.empty?)
                                      end),
         FastlaneCore::ConfigItem.new(key: :url,
                                      env_name: "CY_SENDEMAIL_URL", # The name of the environment variable
                                      description: "AdHoc下载网址", # a short description of this parameter
                                      is_string: true,
                                      verify_block: proc do |value|
                                         UI.user_error!("未指定现在地址") unless (value and not value.empty?)
                                      end)
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          
        ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["Your GitHub/Twitter Name"]
      end

      def self.is_supported?(platform)
        # you can do things like
        #
        #  true
        #
        #  platform == :ios
        #
        #  [:ios, :mac].include?(platform)
        #

        platform == :ios
      end
    end
  end
end
