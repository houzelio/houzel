def rand_string(n = 3)
  SecureRandom.base64(n)
end

FactoryBot.define do
  to_create { |instance| instance.save }

  factory :user do
    transient do
      name { FFaker::Name.name }
    end

    email { FFaker::Internet.email(name) }
    password { FFaker::Internet.password }
    password_confirmation { |u| u.password }

    after(:build) do |u, evaluator|
      u.person = FactoryBot.build(:person,
                                  start_at: DateTime.now,
                                  name: evaluator.name)
    end

    after(:create) do |u|
      u.person.save
      u.person.profile.save
    end
  end

  factory :profile do
    name { FFaker::Name.name }
    birthday { FFaker::Time.date }
    gender { FFaker::Gender.maybe }
    location { FFaker::Address.city }
    phone { FFaker::PhoneNumber.phone_number }
  end

  factory :person do
    transient do
      name { nil }
    end

    after(:build) do |person, evaluator|
      profile = FactoryBot.build(:profile)

      profile.name = evaluator.name if evaluator.name
      person.profile = profile
    end

    after(:create) do |person|
      person.profile.save
    end
  end

  factory :patient do
    name { FFaker::Name.name }
    phone { FFaker::PhoneNumber.phone_number }
    email { FFaker::Internet.email(name) }
    birthday { FFaker::Time.date }
    site { "#{FFaker::Address.city} - #{FFaker::Address.neighborhood }" }
    address { FFaker::Address.street_address }
    zip_code { FFaker::AddressUS.zip_code }
    parent_name { FFaker::Name.name }
    blood_type { FFaker::IdentificationESCO.blood_type }
  end

  factory :visit do
    transient do
      schedule_appointment { false }
      no_medical_history { false }
    end

    start_date { FFaker::Time.datetime.to_datetime }

    after(:build) do |v, evaluator|
      if evaluator.schedule_appointment
        v.status = v.status || "scheduled"
        v.appointment = FactoryBot.build(:appointment, start_date: v.start_date)
      end

      v.medical_history = FactoryBot.build(:medical_history) if !evaluator.no_medical_history

      v.patient = FactoryBot.create(:patient) unless v.patient
      v.examiner = FactoryBot.create(:person) unless v.examiner
    end
  end

  factory :appointment do
    start_date { FFaker::Time.datetime.to_datetime }
    end_date { start_date + 1.hour }
  end

  factory :medical_history do
    complaint {FFaker::HealthcareIpsum.phrase}
    diagnosis {FFaker::HealthcareIpsum.sentence}
    notes {FFaker::HealthcareIpsum.characters}
  end

  factory :service do
    sequence(:name) { |n| "Exam#{n}#{rand_string}" }
    category { ["aaaaa", "bbbbb"].sample }
    value { "#{(rand * (200-100) + 100).round(2)}"}
  end

  factory :invoice_service do
    sequence(:name) { |n| "Exam#{n}#{rand_string}" }
    value { "#{(rand * (200-100) + 100).round(2)}"}

    after(:create) do |is|
      is.invoice = FactoryBot.create(:invoice) unless is.invoice
    end
  end

  factory :invoice do
    remarks { "Remarks#{rand_string(16)}" }

    after(:create) do |i|
      i.patient = FactoryBot.create(:patient) unless i.patient
    end
  end
end
