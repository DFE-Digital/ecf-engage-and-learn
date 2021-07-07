# frozen_string_literal: true

require "rails_helper"

RSpec.describe "CSP violation reporting" do
  let(:params) { { "csp-report" => { "blocked-uri" => "https://malicious.com/script.js" } } }

  before do
    record_csp_violation_events
    allow(Rails.logger).to receive(:error)
    post csp_reports_path, params: params.to_json
  end

  subject { response }

  it { is_expected.to have_http_status(:success) }
  it { expect(Rails.logger).to have_received(:error).with(params).once }
  it { expect(self).to have_recorded_csp_violation(params["csp-report"]) }

  describe "when called without a csp-report" do
    let(:params) { { other: "payload" } }

    it { is_expected.to have_http_status(:success) }
    it { expect(Rails.logger).to_not have_received(:error) }
    it { expect(self).to_not have_recorded_csp_violation }
  end

  describe "when the csp-report contains keys not in our whitelist" do
    let(:params) { { "csp-report" => { "blocked-uri" => "https://malicious.com/script.js", "random" => "information" } } }
    let(:expected_report) { params["csp-report"].slice("blocked-uri") }

    it { expect(Rails.logger).to_not have_received(:error).with(params) }
    it { expect(Rails.logger).to have_received(:error).with({ "csp-report" => expected_report }).once }
    it { expect(self).to have_recorded_csp_violation(expected_report) }
  end

  def has_recorded_csp_violation?(report = nil)
    return @events.any? if report.nil?

    @events.any? { |event| event.payload == report }
  end

private

  def record_csp_violation_events
    @events = []
    ActiveSupport::Notifications.subscribe("tta.csp_violation") do |*args|
      @events << ActiveSupport::Notifications::Event.new(*args)
    end
  end
end

RSpec.describe "Rate limiting" do
  let(:ip) { "1.2.3.4" }

  it_behaves_like "an IP-based rate limited endpoint", "POST /csp_reports", 5, 1.minute do
    def perform_request
      post csp_reports_path, params: {}.to_json, headers: { "REMOTE_ADDR" => ip }
    end
  end
end