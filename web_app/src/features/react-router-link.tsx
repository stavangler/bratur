import * as React from "react"
import { Link, LinkProps } from "react-router-dom"

export const ReactRouterLink = React.forwardRef<
  HTMLAnchorElement,
  Omit<LinkProps, "innerRef">
>((props, ref) => <Link innerRef={ref as any} {...props} />)
ReactRouterLink.displayName = "ReactRouterLink"
