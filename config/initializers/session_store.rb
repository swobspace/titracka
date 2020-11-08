# Rails.application.config.session_store :active_record_store,
#                                        key: '_titracka_session',
#                                        expire_after: 4.weeks
Rails.application.config.session_store :cache_store,
                                       key: '_titracka_session',
                                       compress: true, 
                                       pool_size: 5,
                                       expire_after: 1.year
