FactoryBot.define do
    factory :admin, class: User do
        email "admin@ait.asia"
        password "password"
        password_confirmation "password"
    end

    factory :user, class: User do
        email "user@ait.asia"
        password "password"
        password_confirmation "password"
    end
end
