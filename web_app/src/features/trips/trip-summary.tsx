import React from "react"
import { Card, CardActionArea, CardHeader, CardMedia } from "@material-ui/core"
import { ReactRouterLink } from "../react-router-link"
import { makeStyles } from "@material-ui/core/styles"
import { Trip } from "./model"

type TripProps = {
  trip: Trip
}

const useStyles = makeStyles({
  media: {
    height: 0,
    paddingTop: "56.25%", // 16:9
  },
})

function TripSummary({ trip }: TripProps) {
  const classes = useStyles()

  return (
    <Card>
      <CardActionArea component={ReactRouterLink} to={`/trip/${trip.id}`}>
        <CardHeader
          title={trip.name}
          subheader="Posted by Someone, 3rd September, 13:37"
        />
        <CardMedia
          className={classes.media}
          image={trip.image.small}
          title={trip.image.attribution}
        />
      </CardActionArea>
    </Card>
  )
}

export default TripSummary
