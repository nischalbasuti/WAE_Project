FactoryBot.define do
    factory :admin, class: User do
        id "1"
        email "admin@ait.asia"
        password "password"
        password_confirmation "password"
        global_role "admin"
        created_at "2018-10-22"
    end

    factory :member, class: User do
        id "2"
        email "user@ait.asia"
        password "password"
        password_confirmation "password"
        global_role "member"
        created_at "2018-10-22"
    end

    factory :coordination, class: User do
        id "3"
        email "coordination@ait.asia"
        password "password"
        password_confirmation "password"
        global_role "coordination"
        created_at "2018-10-22"
    end

    factory :ban, class: User do
        id "4"
        email "ban@ait.asia"
        password "password"
        password_confirmation "password"
        global_role "ban"
        created_at "2018-10-22"
    end

    factory :event0, class: Event do
      id "1"
      name "event0"
      description "description0"
      start_time ""
      end_time ""
      created_at "2018-10-22"
      updated_at "2018-10-22"
    end
    factory :forum0, class: Forum do
      id "1"
      title "forum0"
      event_id "1"
      created_at "2018-10-22"
      updated_at "2018-10-22"
    end
    factory :userEvent, class: UserEvent do
      user_id "2"
      event_id "1"
      role "participant"
      created_at "2018-10-22"
      updated_at "2018-10-22"
    end

end
