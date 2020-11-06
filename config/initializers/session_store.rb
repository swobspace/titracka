Rails.application.config.session_store :active_record_store,
                                       key: '_titracka_session',
                                       expire_after: 2.weeks
