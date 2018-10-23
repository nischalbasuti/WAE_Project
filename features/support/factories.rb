FactoryBot.define do
    factory :admin, class: User do
        email "admin@ait.asia"
        password "password"
        password_confirmation "password"
        global_role "admin"
        created_at "2018-10-22"
    end

    factory :member, class: User do
        email "user@ait.asia"
        password "password"
        password_confirmation "password"
        global_role "member"
        created_at "2018-10-22"
    end

    factory :coordination, class: User do
        email "coordination@ait.asia"
        password "password"
        password_confirmation "password"
        global_role "coordination"
        created_at "2018-10-22"
    end

    factory :ban, class: User do
        email "ban@ait.asia"
        password "password"
        password_confirmation "password"
        global_role "ban"
        created_at "2018-10-22"
    end

end
