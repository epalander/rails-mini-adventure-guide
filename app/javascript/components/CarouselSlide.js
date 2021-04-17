import React from 'react';
import { Card, makeStyles } from '@material-ui/core';
import CardMedia from '@material-ui/core/CardMedia';
import {useStyles} from './carouselStyles'

export default function CarouselSlide(props) {
    const { content } = props;
    const classes = useStyles();

    return (
        <Card className={classes.card}>
            <CardMedia
                component="img"
                image={content}
                alt="Adventure-Review-Image"
            />
        </Card>
    );
}