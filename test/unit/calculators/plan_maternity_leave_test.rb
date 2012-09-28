require_relative "../../test_helper"

module SmartAnswer::Calculators
  class PlanMaternityLeaveTest < ActiveSupport::TestCase

    context PlanMaternityLeave do
	    context "formatted due dates" do
		    should "show formatted due date" do
		      @calculator = PlanMaternityLeave.new(due_date: "2012-12-26", start_date: 'days_05')
		    	assert_equal "26 December 2012", @calculator.formatted_due_date
		    end
		  end
		  
		  context "start dates" do
		    should "format start date (weeks 02)" do
		      @calculator = PlanMaternityLeave.new(due_date: "2012-12-26", start_date: 'weeks_02')
					assert_equal "12 December 2012", @calculator.formatted_start_date
		    end
		    should "format start date (days 05)" do
		      @calculator = PlanMaternityLeave.new(due_date: "2012-12-26", start_date: 'days_05')
					assert_equal "21 December 2012", @calculator.formatted_start_date
		    end
		  end

		  context "distance from start dates" do
		    setup do
		      @calculator = PlanMaternityLeave.new(due_date: "2012-12-26", start_date: 'days_05')
		    end
		    should "distance from start (days 05)" do
					assert_equal "5 days", @calculator.distance_start('days_5')
		    end
		    should "distance from start (weeks 02)" do
					assert_equal "2 weeks", @calculator.distance_start('weeks_2')
		    end
	    end

	    context "test date range methods" do
	    	setup do
	    		# /plan-maternity-leave/y/2012-12-09/weeks_2
			    @calculator = PlanMaternityLeave.new(
			      	due_date: "2012-12-09", start_date: 'weeks_2')
	    	end

	    	should "qualifying_week give last date of 1 September 2012" do
		      assert_equal Date.parse("1 September 2012"), @calculator.qualifying_week.last
		    end

	    	should "earliest_start give last date of 23 September 2012" do
		      assert_equal Date.parse("23 September 2012"), @calculator.earliest_start
		    end

	    	should "period_of_ordinary_leave give range of 25 November 2012 - 25 May 2013" do
		      assert_equal "25 November 2012 - 25 May 2013", @calculator.format_date_range(@calculator.period_of_ordinary_leave)
		    end

	    	should "period_of_additional_leave give range of 26 May 2013 - 23 November 2013" do
		    	assert_equal "26 May 2013 - 23 November 2013", @calculator.format_date_range(@calculator.period_of_additional_leave)
		    end

		  end

	  end
  end
end