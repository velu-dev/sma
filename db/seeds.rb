NotifyType.create!([
  { notify_type: "1", desc: "New Request" },
  { notify_type: "2", desc: "Accepted Request" },
  { notify_type: "3", desc: "new post" },
  { notify_type: "4", desc: "new like" },
  { notify_type: "5", desc: "new comment" },
])
User.create!([
  { name: "user 3", email: "user3@user.com", mobile: "3535646464364", password: "user3", otp: "757433" },
  { name: "dsgdgdgsgsd", email: "velu@gmail.com", mobile: "6564565", password: "velu", otp: "300648" },
  { name: "user2", email: "user2@user.com", mobile: "09876543", password: "user2", otp: "373882" },
  { name: "velu", email: "velusamyvnp@gmail.com", mobile: "7397136939", password: "veluvelu", otp: "873127" },
  { name: "user1", email: "user1@user.com", mobile: "1234567890", password: "user1", otp: "129409" },
])
