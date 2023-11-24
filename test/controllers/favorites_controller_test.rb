require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
    setup do 
        login
        @post = posts(:megadrive)
    end

    test "should create favorite" do
        assert_difference('Favorite.count', 1 ) do
            post favorites_url(post_id: @post.id)
        end

        assert_redirected_to post_path(@post)
    end

    test "should  unfavorite" do
        assert_difference('Favorite.count', -1 ) do
            delete favorite_url(post_id: @post.id)
        end

        assert_redirected_to post_path(@post)
    end
end
