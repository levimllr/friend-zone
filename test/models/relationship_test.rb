require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
    def setup
        @reln = Relationship.new(
            befriender_id: people(:michael).id,
            befriended_id: people(:archer).id
        )
    end

    test "should be valid" do
        @reln.valid?
    end

    test "should require a befriender id" do
        @reln.befriender_id = nil
        assert_not @reln.valid?
    end

    test "should require a befriended id" do
        @reln.befriended_id = nil
        assert_not @reln.valid?
    end
end
