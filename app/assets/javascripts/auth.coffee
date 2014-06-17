IntacWebPortal.Auth = Em.Auth.extend
  request: 'jquery'
  response: 'json'
  strategy: 'token'
  session: 'cookie'

  modules: [
    'emberData'
    'authRedirectable'
    'actionRedirectable'
    'rememberable'
  ]

  signInEndPoint: '/sign_in'
  signOutEndPoint: '/sign_out'
  tokenKey: 'auth_token'
  tokenIdKey: 'user_id'
  tokenLocation: 'param'

  emberData:
    userModel: 'user'

  authRedirectable:
    route: 'sign-in'

  actionRedirectable:
    signInRoute: 'users'
    signInSmart: true
    signInBlacklist: ['sign-in']
    signOutRoute: 'post'
# signOutSmart defaults to false already
# since we are not using smart sign out redirect,
# we don't have to touch signOutBlacklist

  rememberable:
    tokenKey: 'remember_token'
    period: 7 # days
    autoRecall: true
