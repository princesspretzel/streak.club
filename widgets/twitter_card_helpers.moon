class TwitterCardHelpers
  twitter_card_default_description: "Streak Club is a place for staying motivated by doing something creative every day or week"

  twitter_card_for_streak: (streak, card_images={}) =>
    user = streak\get_user!

    if twitter = user\twitter_handle!
      meta name: "twitter:creator", content: "@#{twitter}"

    card_type = switch #card_images
      when 4
        "gallery"
      when 0
        "summary"
      else
        "summary_large_image"

    meta name: "twitter:card", content: card_type
    meta name: "twitter:site", content: "@thestreakclub"

    meta name: "twitter:title", content: streak.title
    meta name: "twitter:description", content: "#{streak.short_description} - #{@twitter_card_default_description}"

    switch card_type
      when "gallery"
        for i, upload in ipairs card_images
          meta name: "twitter:image#{i - 1}", content: @build_url @url_for upload
        nil
      when "summary_large_image"
        meta name: "twitter:twitter:image:src", content: @build_url @url_for card_images[1]

  twitter_card_for_submission: (submission) =>
    uploads = submission\get_uploads!
    first_image = nil

    for u in *uploads
      if u\is_image!
        first_image = u
        break

    user = submission\get_user!
    profile = user\get_user_profile!

    meta name: "twitter:card", content: "summary_large_image"
    meta name: "twitter:site", content: "@thestreakclub"

    if twitter = profile\twitter_handle!
      meta name: "twitter:creator", content: "@#{twitter}"

    meta name: "twitter:title", content: submission\meta_title!
    meta name: "twitter:description", content: @twitter_card_default_description

    if first_image
      meta {
        name: "twitter:image"
        content: @build_url @url_for first_image
      }

