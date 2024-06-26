require "validify_me/data_validator"
require "validify_me/validator/array_validator"
require "validify_me/errors/empty_parameter_error"
require "validify_me/errors/constraint_parameter_error"
require "validify_me/errors/wrong_data_type_error"
require "dry/monads"
require "dry/matcher/result_matcher"

require "pry"

RSpec.describe ValidifyMe::Validator::ArrayValidator do
  subject { described_class.new(param_definition, param_value) }

  let(:required) { true }
  let(:param_name) { :codes }

  let(:param_definition) do
    ValidifyMe::DataValidator::ParameterDefinition.new(param_name, required: required)
      .value(:array, min_size: 1000, max_size: 5000, each: :int)
  end

  context "when non-array type is provided" do
    let(:param_value) { "Hello world" }

    it "should raise WrongDataTypeError" do
      expect(subject.validate).to eq(Dry::Monads::Failure(:wrong_data_type))
    end
  end

  context "empty param value" do
    let(:param_value) { [] }

    it "should raise EmptyParameterError" do
      expect(subject.validate).to eq(Dry::Monads::Failure(:empty_parameter))
    end
  end

  context "correct data type is provided" do
    let(:param_value) do
      Array.new(15000) { rand(1000..5000) }
    end

    it 'shouldn\'t raise any error' do
      expect { subject.validate }.not_to raise_error
    end
  end

  context "when string provided and all integers are expected" do
    let(:param_value) { [2512, 2561, 2109, 4921, "hello world"] }

    it "should raise ConstraintParameterError" do
      expect { subject.validate }.to raise_error(ValidifyMe::Errors::ConstraintParameterError)
    end
  end

  context "when value provided is smaller than min_size constraint" do
    let(:param_value) { [2512, 2561, 2109, 999] }

    it "should raise ConstraintParameterError" do
      expect { subject.validate }.to raise_error(ValidifyMe::Errors::ConstraintParameterError)
    end
  end

  context "when value provided is greater than max_size constraint" do
    let(:param_value) { [2512, 2561, 2109, 5001] }

    it "should raise ConstraintParameterError" do
      expect { subject.validate }.to raise_error(ValidifyMe::Errors::ConstraintParameterError)
    end
  end
end
