require 'colorize'
require 'fileutils'

# To use Terraform 0.12 syntax, set ENV variable TERRAFORM_VERSION to 0.12.*

def lint_tf
  # Do the linting on current working folder.
  print "INFO: Linting Terraform configurations...\n".yellow  
  

  if ENV['TERRAFORM_VERSION'].nil? || ENV['TERRAFORM_VERSION'].start_with?("0.11.")
    message = `terraform validate -check-variables=false 2>&1`
  elsif ENV['TERRAFORM_VERSION'].start_with?("0.12.")
    message = `terraform validate >/dev/null`
  end

  # Check the linting message.
  if not message.empty?
    raise "ERROR: Linting Terraform configurations failed!\n#{message}\n".red
  else
    print "INFO: Done!\n".green
  end
end

def style_tf
  # Do the style checking on current working folder.
  print "INFO: Styling Terraform configurations...\n".yellow  
  if ENV['TERRAFORM_VERSION'].nil? || ENV['TERRAFORM_VERSION'].start_with?("0.11.")
    message = `terraform fmt -check=true 2>&1`
  elsif ENV['TERRAFORM_VERSION'].start_with?("0.12.")
    message = `terraform fmt -check 2>&1`
  end

  # Check the styling message.
  if not message.empty?
    raise "ERROR: Styling Terraform configurations failed!\n#{message}\n".red
  else
    print "INFO: Done!\n".green
  end
end

def format_tf
  # Apply the canonical format and style on current working folder.
  print "INFO: Formatting Terraform configurations...\n".yellow
  if ENV['TERRAFORM_VERSION'].nil? || ENV['TERRAFORM_VERSION'].start_with?("0.11.")
    message = `terraform fmt -diff=true 2>&1`
  elsif ENV['TERRAFORM_VERSION'].start_with?("0.12.")
    message = `terraform fmt -diff 2>&1`
  end

  # Check the styling message.
  if not message.empty?
    raise "ERROR: Formatting Terraform configurations failed!\n#{message}\n".red
  else
    print "INFO: Done!\n".green
  end
end
