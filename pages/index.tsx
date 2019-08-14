import React from 'react'
import Router from 'next/router'
import { NextPageContext } from 'next'

const graphqiUrl = '/api/graphqi'

const RedirectPage = (): JSX.Element => {
  return <div />
}

RedirectPage.getInitialProps = ({ res }: NextPageContext) => {
  if (res) {
    res.writeHead(302, { Location: graphqiUrl })
    res.end()
  } else {
    Router.push(graphqiUrl)
  }
}

export default RedirectPage
